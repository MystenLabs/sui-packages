module 0xef49b330e518ec2944eae90db5c3b3d797f8c6a9b2e0215fe05a049792dad201::ucs {
    struct UCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: UCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UCS>(arg0, 6, b"UCS", b"UniCrystal on sui", x"436f6d6d756e6974793a204120676174686572696e6720706c61636520666f722070656f706c652077686f206c6f76652c20726573656172636820616e6420646f20627573696e65737320696e20746865206669656c64206f66206372797374616c6c6f6772617068792e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_02_01_10_51_56_2901469adf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UCS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UCS>>(v1);
    }

    // decompiled from Move bytecode v6
}

