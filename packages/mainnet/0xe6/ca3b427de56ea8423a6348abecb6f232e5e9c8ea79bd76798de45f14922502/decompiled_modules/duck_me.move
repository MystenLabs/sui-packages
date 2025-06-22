module 0xe6ca3b427de56ea8423a6348abecb6f232e5e9c8ea79bd76798de45f14922502::duck_me {
    struct DUCK_ME has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCK_ME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCK_ME>(arg0, 9, b"DUCK", b"duck me", b"duck you and duck me", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/e3af6dea-233f-4cb6-a83c-32783ae953e4.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUCK_ME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCK_ME>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

