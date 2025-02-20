module 0x1aac168581f841a50a7f9be0cf90474e7991b57671274c62448069b53c2d67a3::mmtk {
    struct MMTK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMTK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMTK>(arg0, 9, b"MMTK", b"My My token", b"This is a test token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MMTK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMTK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MMTK>>(v1);
    }

    // decompiled from Move bytecode v6
}

