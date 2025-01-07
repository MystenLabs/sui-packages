module 0x61edf75b57e3acb53c7c9650120d71debb6af5a79745767ab81adac25f61f4ea::suim69 {
    struct SUIM69 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIM69, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIM69>(arg0, 6, b"SUIM69", b"SUIROOM 6900", b"SUI ROOM 6900 leverages the power of artificial intelligence to ensure top-notch security for every transaction. $SUIM69", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_21_23_05_41_bef6ea4493.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIM69>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIM69>>(v1);
    }

    // decompiled from Move bytecode v6
}

