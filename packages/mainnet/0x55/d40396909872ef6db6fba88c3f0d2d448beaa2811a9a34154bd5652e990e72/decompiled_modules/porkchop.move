module 0x55d40396909872ef6db6fba88c3f0d2d448beaa2811a9a34154bd5652e990e72::porkchop {
    struct PORKCHOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PORKCHOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PORKCHOP>(arg0, 6, b"PORKCHOP", b"Porkchop On Sui", b"Porkchop is Doug Funnie's beloved dog from the hit kids cartoon 'Doug'.  He's famous for his musical skills, acting, sports, and detective work. He now lives on the #SUI blockchain as a fan tribute and is the unofficial mascot of #SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tak_berjudul34_20241222152959_788901d671.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PORKCHOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PORKCHOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

