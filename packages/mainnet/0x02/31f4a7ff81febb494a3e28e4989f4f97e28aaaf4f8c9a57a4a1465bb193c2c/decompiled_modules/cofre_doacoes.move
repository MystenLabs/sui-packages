module 0x231f4a7ff81febb494a3e28e4989f4f97e28aaaf4f8c9a57a4a1465bb193c2c::cofre_doacoes {
    struct Campanha has store, key {
        id: 0x2::object::UID,
        organizador: address,
        titulo: 0x1::string::String,
        descricao: 0x1::string::String,
        meta_sui: u64,
        fundos: 0x2::balance::Balance<0x2::sui::SUI>,
        deadline_ms: u64,
        status: u8,
        numero_doadores: u64,
    }

    struct CampanhaCriada has copy, drop, store {
        campanha_id: 0x2::object::ID,
        organizador: address,
        meta_sui: u64,
        deadline_ms: u64,
    }

    struct DoacaoRecebida has copy, drop, store {
        campanha_id: 0x2::object::ID,
        doador: address,
        valor: u64,
        total_apos: u64,
    }

    struct CampanhaEncerrada has copy, drop, store {
        campanha_id: 0x2::object::ID,
        motivo_status: u8,
        total_final: u64,
    }

    fun atualiza_status(arg0: &mut Campanha, arg1: &0x2::clock::Clock) {
        if (arg0.status != 0) {
            return
        };
        if (0x2::clock::timestamp_ms(arg1) > arg0.deadline_ms) {
            arg0.status = 2;
        };
    }

    public fun criar_campanha(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = nova_campanha(v0, arg0, arg1, arg2, arg3, arg4, arg5);
        let v2 = CampanhaCriada{
            campanha_id : 0x2::object::id<Campanha>(&v1),
            organizador : v0,
            meta_sui    : arg2,
            deadline_ms : arg3,
        };
        0x2::event::emit<CampanhaCriada>(v2);
        0x2::transfer::share_object<Campanha>(v1);
    }

    public fun doar(arg0: &mut Campanha, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        atualiza_status(arg0, arg1);
        assert!(arg0.status == 0, 2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fundos, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        arg0.numero_doadores = arg0.numero_doadores + 1;
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.fundos);
        let v1 = DoacaoRecebida{
            campanha_id : 0x2::object::id<Campanha>(arg0),
            doador      : 0x2::tx_context::sender(arg3),
            valor       : 0x2::coin::value<0x2::sui::SUI>(&arg2),
            total_apos  : v0,
        };
        0x2::event::emit<DoacaoRecebida>(v1);
        if (v0 >= arg0.meta_sui) {
            arg0.status = 1;
        };
    }

    fun nova_campanha(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : Campanha {
        assert!(arg4 > 0x2::clock::timestamp_ms(arg5), 1);
        assert!(arg3 > 0, 1);
        Campanha{
            id              : 0x2::object::new(arg6),
            organizador     : arg0,
            titulo          : arg1,
            descricao       : arg2,
            meta_sui        : arg3,
            fundos          : 0x2::balance::zero<0x2::sui::SUI>(),
            deadline_ms     : arg4,
            status          : 0,
            numero_doadores : 0,
        }
    }

    public fun sacar(arg0: &mut Campanha, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.organizador, 3);
        atualiza_status(arg0, arg1);
        let v1 = arg0.status;
        assert!(v1 == 1 || v1 == 2, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.fundos), arg2), v0);
        let v2 = CampanhaEncerrada{
            campanha_id   : 0x2::object::id<Campanha>(arg0),
            motivo_status : v1,
            total_final   : 0x2::balance::value<0x2::sui::SUI>(&arg0.fundos),
        };
        0x2::event::emit<CampanhaEncerrada>(v2);
    }

    // decompiled from Move bytecode v6
}

