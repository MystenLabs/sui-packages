module 0x71b14eb13f771d7fe4fa339dc17cb65c9f0c75c812424101ca9217911e42ff0f::bos {
    struct BOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOS>(arg0, 6, b"BOS", b"Bubble On SUi", b"Its me, Bubble! Floating through the skies of Sui,bringing joy and looking out for every traveller. There are places youve never imagined waiting to be discovered,and theres always something exciting just ahead.Lets see where were off to next.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BCOOL_db5474111d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

