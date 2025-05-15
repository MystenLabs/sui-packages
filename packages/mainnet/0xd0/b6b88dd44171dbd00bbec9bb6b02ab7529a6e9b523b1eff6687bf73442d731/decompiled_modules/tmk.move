module 0xd0b6b88dd44171dbd00bbec9bb6b02ab7529a6e9b523b1eff6687bf73442d731::tmk {
    struct TMK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TMK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TMK>(arg0, 9, b"TMK", b"THE MASK", b"A crypto coin inspired by mysterious masks! Built on blockchain for privacy and security, it aims to revolutionize digital finance with anonymous transactions. The innovative team empowers the crypto community. Join the covert mission and invest in a boundless future with $MASK!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/0e3f082dfa6aef4bf255a60d26c82a99blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TMK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TMK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

