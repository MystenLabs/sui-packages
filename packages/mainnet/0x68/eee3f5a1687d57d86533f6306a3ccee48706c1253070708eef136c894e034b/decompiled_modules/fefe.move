module 0x68eee3f5a1687d57d86533f6306a3ccee48706c1253070708eef136c894e034b::fefe {
    struct FEFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FEFE>(arg0, 6, b"FEFE", b"Fefe.20", b"Think youve seen everything Furies universe has to offer? Think again. FEFE 2.0 is here to take your internet experience to the next levelfunnier, weirder, and more iconic than ever. This isnt just a character, its a vibe: unpredictable, lovable, ...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000049728_f3e635d50b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FEFE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FEFE>>(v1);
    }

    // decompiled from Move bytecode v6
}

