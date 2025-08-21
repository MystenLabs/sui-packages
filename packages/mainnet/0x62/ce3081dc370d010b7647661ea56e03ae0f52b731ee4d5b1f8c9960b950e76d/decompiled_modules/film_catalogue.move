module 0x62ce3081dc370d010b7647661ea56e03ae0f52b731ee4d5b1f8c9960b950e76d::film_catalogue {
    struct Film_catalogue has store, key {
        id: 0x2::object::UID,
        films: 0x2::vec_map::VecMap<u64, Film>,
    }

    struct Film has copy, drop, store {
        titulo: 0x1::string::String,
        director: 0x1::string::String,
        publicado: u16,
        categoria: 0x1::string::String,
        protagonista: 0x1::string::String,
        calificacion: u8,
    }

    public fun add_film(arg0: &mut Film_catalogue, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u16, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u8) {
        let v0 = Film{
            titulo       : arg2,
            director     : arg3,
            publicado    : arg4,
            categoria    : arg5,
            protagonista : arg6,
            calificacion : arg7,
        };
        assert!(!0x2::vec_map::contains<u64, Film>(&arg0.films, &arg1), 10);
        0x2::vec_map::insert<u64, Film>(&mut arg0.films, arg1, v0);
    }

    public fun create_catalogue(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Film_catalogue{
            id    : 0x2::object::new(arg0),
            films : 0x2::vec_map::empty<u64, Film>(),
        };
        0x2::transfer::transfer<Film_catalogue>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun delete_catalogue(arg0: Film_catalogue) {
        let Film_catalogue {
            id    : v0,
            films : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun delete_film(arg0: &mut Film_catalogue, arg1: u64) {
        assert!(0x2::vec_map::contains<u64, Film>(&arg0.films, &arg1), 11);
        let (_, _) = 0x2::vec_map::remove<u64, Film>(&mut arg0.films, &arg1);
    }

    public fun update_calificacion(arg0: &mut Film_catalogue, arg1: u64, arg2: u8) {
        assert!(0x2::vec_map::contains<u64, Film>(&arg0.films, &arg1), 11);
        0x2::vec_map::get_mut<u64, Film>(&mut arg0.films, &arg1).calificacion = arg2;
    }

    public fun update_categoria(arg0: &mut Film_catalogue, arg1: u64, arg2: 0x1::string::String) {
        assert!(0x2::vec_map::contains<u64, Film>(&arg0.films, &arg1), 11);
        0x2::vec_map::get_mut<u64, Film>(&mut arg0.films, &arg1).categoria = arg2;
    }

    public fun update_director(arg0: &mut Film_catalogue, arg1: u64, arg2: 0x1::string::String) {
        assert!(0x2::vec_map::contains<u64, Film>(&arg0.films, &arg1), 11);
        0x2::vec_map::get_mut<u64, Film>(&mut arg0.films, &arg1).director = arg2;
    }

    public fun update_protagonista(arg0: &mut Film_catalogue, arg1: u64, arg2: 0x1::string::String) {
        assert!(0x2::vec_map::contains<u64, Film>(&arg0.films, &arg1), 11);
        0x2::vec_map::get_mut<u64, Film>(&mut arg0.films, &arg1).protagonista = arg2;
    }

    public fun update_published(arg0: &mut Film_catalogue, arg1: u64, arg2: u16) {
        assert!(0x2::vec_map::contains<u64, Film>(&arg0.films, &arg1), 11);
        0x2::vec_map::get_mut<u64, Film>(&mut arg0.films, &arg1).publicado = arg2;
    }

    public fun update_tittle(arg0: &mut Film_catalogue, arg1: u64, arg2: 0x1::string::String) {
        assert!(0x2::vec_map::contains<u64, Film>(&arg0.films, &arg1), 11);
        0x2::vec_map::get_mut<u64, Film>(&mut arg0.films, &arg1).titulo = arg2;
    }

    // decompiled from Move bytecode v6
}

