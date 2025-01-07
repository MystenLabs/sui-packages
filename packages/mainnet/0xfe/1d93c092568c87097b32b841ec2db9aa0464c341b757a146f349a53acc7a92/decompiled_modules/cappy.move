module 0xfe1d93c092568c87097b32b841ec2db9aa0464c341b757a146f349a53acc7a92::cappy {
    struct CAPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPPY>(arg0, 6, b"CAPPY", b"SUI CAPPY", b"Chill with $CAPPY , be Cappy at the creek", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cappy_b972e61ada.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

