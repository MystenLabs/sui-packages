module 0x2a1d44502909580a93986f525508dfc509081520a4842dececf8641425d8b4b7::b4u_ {
    struct B4U_ has drop {
        dummy_field: bool,
    }

    fun init(arg0: B4U_, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B4U_>(arg0, 9, b"B4U_", b"B-HAIRWAYS", b"We are the first hair utility token to prove how hairs are very much impeccable to all female genders all over the world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b46ccc84-ecf6-430e-8b82-bc18f52e1421.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B4U_>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<B4U_>>(v1);
    }

    // decompiled from Move bytecode v6
}

