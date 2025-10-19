module 0xd21ff8286f2305f07ee7b3b14016e8f7707e27dc9b35920ec35f8b16014c77a5::cursos {
    struct InformacionUsuario has store, key {
        id: 0x2::object::UID,
        nombre_completo: 0x1::string::String,
        edad: u8,
        estado: 0x1::string::String,
        correo_electronico: 0x1::string::String,
        curso_interes: 0x1::string::String,
    }

    public fun editar_correo(arg0: &mut InformacionUsuario, arg1: 0x1::string::String) {
        arg0.correo_electronico = arg1;
    }

    public fun editar_curso(arg0: &mut InformacionUsuario, arg1: 0x1::string::String) {
        arg0.curso_interes = arg1;
    }

    public fun eliminar_registro(arg0: InformacionUsuario) {
        let InformacionUsuario {
            id                 : v0,
            nombre_completo    : _,
            edad               : _,
            estado             : _,
            correo_electronico : _,
            curso_interes      : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun get_correo_electronico(arg0: &InformacionUsuario) : &0x1::string::String {
        &arg0.correo_electronico
    }

    public fun get_curso_interes(arg0: &InformacionUsuario) : &0x1::string::String {
        &arg0.curso_interes
    }

    public fun get_nombre_completo(arg0: &InformacionUsuario) : &0x1::string::String {
        &arg0.nombre_completo
    }

    public fun mi_registro(arg0: &InformacionUsuario) : (&0x1::string::String, u8, &0x1::string::String, &0x1::string::String, &0x1::string::String) {
        (&arg0.nombre_completo, arg0.edad, &arg0.estado, &arg0.correo_electronico, &arg0.curso_interes)
    }

    public fun registrar_usuario(arg0: 0x1::string::String, arg1: u8, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = InformacionUsuario{
            id                 : 0x2::object::new(arg5),
            nombre_completo    : arg0,
            edad               : arg1,
            estado             : arg2,
            correo_electronico : arg3,
            curso_interes      : arg4,
        };
        0x2::transfer::transfer<InformacionUsuario>(v0, 0x2::tx_context::sender(arg5));
    }

    // decompiled from Move bytecode v6
}

