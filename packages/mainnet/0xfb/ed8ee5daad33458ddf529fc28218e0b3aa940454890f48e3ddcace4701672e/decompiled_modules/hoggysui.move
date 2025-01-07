module 0xfbed8ee5daad33458ddf529fc28218e0b3aa940454890f48e3ddcace4701672e::hoggysui {
    struct HOGGYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOGGYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOGGYSUI>(arg0, 6, b"HOGGYSUI", b"HAPPY HOGGY ON SUI", b"Happiest cuttest HOG on the SUI eco-system ! Happy hogging !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/HOGGY_2_625a772562.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOGGYSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOGGYSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

