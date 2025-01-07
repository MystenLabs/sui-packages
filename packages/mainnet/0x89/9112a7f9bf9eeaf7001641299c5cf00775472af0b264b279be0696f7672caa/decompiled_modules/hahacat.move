module 0x899112a7f9bf9eeaf7001641299c5cf00775472af0b264b279be0696f7672caa::hahacat {
    struct HAHACAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAHACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAHACAT>(arg0, 9, b"HAHACAT", b"HAHA CAT", x"4c65742074686520636174206c61756768696e6720617420796f7520f09f9980f09f98b9", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ddac54a4-b3dd-4c3e-9dcf-ab3b70de8cc7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAHACAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAHACAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

