module 0xe5319fd83e157d9b7847c752934becfc3a35e224e56400b289a459cbed2682ba::avocado {
    struct AVOCADO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AVOCADO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AVOCADO>(arg0, 6, b"Avocado", b"Avocado Cat Portal", x"492068617665206265656e206578706572696d656e74696e67207769746820697420657665722073696e6365206920676f74206265746120616e64207472756c792062656c696576652047726f6b2077696c6c206368616e6765206f7572206c69666520666f72657665722e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/S_Ea_K_16i_400x400_88c7494640.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AVOCADO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AVOCADO>>(v1);
    }

    // decompiled from Move bytecode v6
}

