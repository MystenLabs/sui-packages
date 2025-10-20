module 0x2052efc7be84d363dce6b450814e3779ab7ac5d9cab740011191159e468ff638::galeria_micro_poemas {
    struct MicroPoema has store, key {
        id: 0x2::object::UID,
        autor: address,
        contenido: vector<u8>,
        likes: u64,
        timestamp: u64,
    }

    struct Galeria has key {
        id: 0x2::object::UID,
        fondos: 0x2::balance::Balance<0x2::sui::SUI>,
        total_poemas: u64,
    }

    struct PoemaPublicado has copy, drop {
        poema_id: 0x2::object::ID,
        autor: address,
    }

    struct LikeDado has copy, drop {
        poema_id: 0x2::object::ID,
        nuevo_total: u64,
    }

    public fun compartir_poema(arg0: MicroPoema) {
        0x2::transfer::public_share_object<MicroPoema>(arg0);
    }

    public fun dar_like(arg0: &mut MicroPoema) {
        arg0.likes = arg0.likes + 1;
        let v0 = LikeDado{
            poema_id    : 0x2::object::id<MicroPoema>(arg0),
            nuevo_total : arg0.likes,
        };
        0x2::event::emit<LikeDado>(v0);
    }

    public fun eliminar_poema(arg0: MicroPoema, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.autor == 0x2::tx_context::sender(arg1), 3);
        let MicroPoema {
            id        : v0,
            autor     : _,
            contenido : _,
            likes     : _,
            timestamp : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Galeria{
            id           : 0x2::object::new(arg0),
            fondos       : 0x2::balance::zero<0x2::sui::SUI>(),
            total_poemas : 0,
        };
        0x2::transfer::share_object<Galeria>(v0);
    }

    public fun publicar_poema(arg0: &mut Galeria, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg2) <= 280, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 100000000, 2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fondos, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.total_poemas = arg0.total_poemas + 1;
        let v0 = MicroPoema{
            id        : 0x2::object::new(arg3),
            autor     : 0x2::tx_context::sender(arg3),
            contenido : arg2,
            likes     : 0,
            timestamp : 0x2::tx_context::epoch(arg3),
        };
        let v1 = PoemaPublicado{
            poema_id : 0x2::object::id<MicroPoema>(&v0),
            autor    : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<PoemaPublicado>(v1);
        0x2::transfer::transfer<MicroPoema>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun ver_contenido(arg0: &MicroPoema) : vector<u8> {
        arg0.contenido
    }

    public fun ver_fondos_galeria(arg0: &Galeria) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.fondos)
    }

    public fun ver_stats(arg0: &MicroPoema) : (address, u64, u64) {
        (arg0.autor, arg0.likes, arg0.timestamp)
    }

    // decompiled from Move bytecode v6
}

