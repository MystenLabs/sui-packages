module 0xb1901d6292bd063d1557d75be11c1c7e8e1e7b9a0bf89e3f05849e828352ae4e::ray {
    struct RAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAY>(arg0, 6, b"RAY", b"Ray on Sui", x"574520415245204c495645212121200a0a54686520626573742052415920696e205375692121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/reay_d41156c7cd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

