module 0x11eb1d84c652617820136d84ac48851020361dd911d29c609fe4634334255296::kremit {
    struct KREMIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KREMIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KREMIT>(arg0, 6, b"KREMIT", b"SuiKremitOnSui", b"Ribbiting News: Meet Sui Kermit, the Hopping Meme Frog of Sui Blockchain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241005_174158_3417eeee07.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KREMIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KREMIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

