module 0x89e0b3dba1bcfd7fbfe3bd7a5667044af57d662587462f0ce225b6eca2a03202::api_gateway {
    struct Gateway has key {
        id: 0x2::object::UID,
        admin: address,
        clientes: 0x2::table::Table<address, Cliente>,
        endpoints: 0x2::table::Table<0x1::string::String, Endpoint>,
        logs_acceso: 0x2::table::Table<u64, LogAcceso>,
        contador_logs: u64,
    }

    struct Cliente has store {
        api_key: 0x1::string::String,
        requests_hoy: u64,
        limite_diario: u64,
        activo: bool,
        total_requests: u64,
    }

    struct Endpoint has store {
        ruta: 0x1::string::String,
        metodo: 0x1::string::String,
        rate_limit: u64,
        publico: bool,
        total_llamadas: u64,
    }

    struct LogAcceso has store {
        id: u64,
        cliente: address,
        endpoint: 0x1::string::String,
        timestamp: u64,
        codigo_respuesta: u64,
        tiempo_respuesta: u64,
    }

    public fun agregar_endpoint(arg0: &mut Gateway, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg5), 1);
        let v0 = 0x1::string::utf8(arg1);
        let v1 = Endpoint{
            ruta           : v0,
            metodo         : 0x1::string::utf8(arg2),
            rate_limit     : arg3,
            publico        : arg4,
            total_llamadas : 0,
        };
        0x2::table::add<0x1::string::String, Endpoint>(&mut arg0.endpoints, v0, v1);
    }

    public fun crear_gateway(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Gateway{
            id            : 0x2::object::new(arg0),
            admin         : 0x2::tx_context::sender(arg0),
            clientes      : 0x2::table::new<address, Cliente>(arg0),
            endpoints     : 0x2::table::new<0x1::string::String, Endpoint>(arg0),
            logs_acceso   : 0x2::table::new<u64, LogAcceso>(arg0),
            contador_logs : 0,
        };
        0x2::transfer::share_object<Gateway>(v0);
    }

    public fun hacer_request(arg0: &mut Gateway, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::table::borrow_mut<0x1::string::String, Endpoint>(&mut arg0.endpoints, 0x1::string::utf8(arg1));
        if (!v1.publico) {
            assert!(0x2::table::contains<address, Cliente>(&arg0.clientes, v0), 2);
            let v2 = 0x2::table::borrow_mut<address, Cliente>(&mut arg0.clientes, v0);
            assert!(v2.activo, 3);
            assert!(v2.requests_hoy < v2.limite_diario, 4);
            v2.requests_hoy = v2.requests_hoy + 1;
            v2.total_requests = v2.total_requests + 1;
        };
        v1.total_llamadas = v1.total_llamadas + 1;
    }

    public fun registrar_cliente(arg0: &mut Gateway, arg1: address, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg4), 1);
        let v0 = Cliente{
            api_key        : 0x1::string::utf8(arg2),
            requests_hoy   : 0,
            limite_diario  : arg3,
            activo         : true,
            total_requests : 0,
        };
        0x2::table::add<address, Cliente>(&mut arg0.clientes, arg1, v0);
    }

    public fun registrar_log(arg0: &mut Gateway, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = LogAcceso{
            id               : arg0.contador_logs,
            cliente          : 0x2::tx_context::sender(arg4),
            endpoint         : 0x1::string::utf8(arg1),
            timestamp        : 0,
            codigo_respuesta : arg2,
            tiempo_respuesta : arg3,
        };
        0x2::table::add<u64, LogAcceso>(&mut arg0.logs_acceso, arg0.contador_logs, v0);
        arg0.contador_logs = arg0.contador_logs + 1;
    }

    public fun resetear_limite_diario(arg0: &mut Gateway, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 1);
        0x2::table::borrow_mut<address, Cliente>(&mut arg0.clientes, arg1).requests_hoy = 0;
    }

    // decompiled from Move bytecode v6
}

