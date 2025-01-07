module 0xb6f9c72cafb9d8a5806542b299e76a524c6b485c4776e4d01d57c46b9f8f7ad3::kopfff {
    struct KOPFFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOPFFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOPFFF>(arg0, 6, b"Kopfff", b"carinnakopf", b"carinna kopf ape chain go to 67mil", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ekran_Resmi_2024_10_27_17_23_35_d312cdf624.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOPFFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOPFFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

