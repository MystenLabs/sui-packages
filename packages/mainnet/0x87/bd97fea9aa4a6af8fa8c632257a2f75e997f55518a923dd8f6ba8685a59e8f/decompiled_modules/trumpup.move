module 0x87bd97fea9aa4a6af8fa8c632257a2f75e997f55518a923dd8f6ba8685a59e8f::trumpup {
    struct TRUMPUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPUP>(arg0, 6, b"Trumpup", b"TrumpUP", b"Make America great again! Stand with Trump to defend freedom and prosperity. Together, we fight for the future and build a better nation. United we stand, Trump, let's go!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_dc131a30c1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

