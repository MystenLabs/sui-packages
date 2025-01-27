module 0x1d8a65c6c032f9448f3c47bd2953ebfd3deed4eff92c50f7912d51c9de33d548::suijack {
    struct SUIJACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIJACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIJACK>(arg0, 9, b"Suijack", b"suijackjack", b"your favorite baby superhero is ready to take you to the moon supermemecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c1f78e6149bc229a1f3953333ccd58d1blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIJACK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIJACK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

