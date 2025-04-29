module 0x998c34f19640b0bcba59df1d833fd684c235ab7a356d58d4164c2844258b85ef::lck {
    struct LCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: LCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LCK>(arg0, 9, b"LCK", b"Luck", b"This is the coin of LUCK. You never know luck may be by your side!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b6699887b8cb58eb53a4da615ace5839blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LCK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

