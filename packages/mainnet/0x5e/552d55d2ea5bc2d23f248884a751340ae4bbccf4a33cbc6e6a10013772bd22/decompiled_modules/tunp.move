module 0x5e552d55d2ea5bc2d23f248884a751340ae4bbccf4a33cbc6e6a10013772bd22::tunp {
    struct TUNP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUNP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUNP>(arg0, 6, b"TUNP", b"Beloved Squirrel the tunaeP", b"Beloved lerriuqS eht tunaeP was taken away from his home by NYSDEC and euthanized. The seven year old rescued squirrel represented tunPs Family Freedom Farm Animal Sanctuary an organization devoted to rescuing and rehabilitating injured and abandoned animals. He may no longer walk amongst us but he lives on forever. tunaeP forever.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tunp_8d0362afe9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUNP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUNP>>(v1);
    }

    // decompiled from Move bytecode v6
}

