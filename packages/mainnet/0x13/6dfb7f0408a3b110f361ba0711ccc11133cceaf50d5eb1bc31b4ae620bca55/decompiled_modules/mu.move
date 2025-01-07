module 0x136dfb7f0408a3b110f361ba0711ccc11133cceaf50d5eb1bc31b4ae620bca55::mu {
    struct MU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MU>(arg0, 6, b"MU", b"MU token", b"Mu is a playful, curious kitten from Bao Loc, Vietnam. With her silky fur and bright eyes, she charms everyone she meets, bringing joy to her peaceful surroundings.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MU_091f93034a.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MU>>(v1);
    }

    // decompiled from Move bytecode v6
}

