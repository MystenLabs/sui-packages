module 0x8dd4e85ec432c0741ee1a9c0b7b3b3aec3a3e9f483ed52df76856d5d7e06f9ab::suigma {
    struct SUIGMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGMA>(arg0, 9, b"suigma", b"Sui Ligma", b"Ligma will take over the space", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://framerusercontent.com/images/Kn3gQ1YSGTX9Qg3VANrvLJU14.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIGMA>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGMA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

