module 0x451675c7f4c9c350cf8114df0379e23d5c92c76030cb743c85c3c9e447810daa::inu {
    struct INU has drop {
        dummy_field: bool,
    }

    fun init(arg0: INU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INU>(arg0, 6, b"Inu", b"Doginu", b"Meet $DOGINU, the closest relative to $DOG on the BTC network. A meme coin based on SOLANA  and SUI network with an ambitious mission: to reach the moon and beyond!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1674784029487_85aa0b58febdd71098f8ace9c9d312d9_f91d078f50.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INU>>(v1);
    }

    // decompiled from Move bytecode v6
}

