module 0xa5cb3f76be94829b4643c3df00651675b3fe1d709d1069212a02318e6bdd6398::dwf {
    struct DWF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DWF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DWF>(arg0, 6, b"DWF", b"DWF LABS", b"sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dwf_labs_logo_65c8137bd9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DWF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DWF>>(v1);
    }

    // decompiled from Move bytecode v6
}

