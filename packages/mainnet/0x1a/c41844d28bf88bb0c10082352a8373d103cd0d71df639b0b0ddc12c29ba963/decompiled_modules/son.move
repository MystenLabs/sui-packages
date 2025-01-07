module 0x1ac41844d28bf88bb0c10082352a8373d103cd0d71df639b0b0ddc12c29ba963::son {
    struct SON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SON>(arg0, 6, b"SON", b"SUI ON NELLY", b"An Homage to Discords 404 Page Mascot, Nelly the Robot Hamster on Sui! | ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/nely_fb63af9d68.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SON>>(v1);
    }

    // decompiled from Move bytecode v6
}

