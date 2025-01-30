module 0x51b586c2601d0b62465bd39af028054c060a5aa0f82471a0464e26841738e52e::rbt {
    struct RBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RBT>(arg0, 6, b"Rbt", b"Robotalks AI", b"Your AI Wingman for Customer Service Excellence Talk Less, Solve More  Let RoboTalks do the heavy lifting while you sit back and watch your customers smile.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2331_d81fb1c5a2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RBT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RBT>>(v1);
    }

    // decompiled from Move bytecode v6
}

