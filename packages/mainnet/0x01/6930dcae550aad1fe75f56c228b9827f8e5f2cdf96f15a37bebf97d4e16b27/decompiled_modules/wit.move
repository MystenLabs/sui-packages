module 0x16930dcae550aad1fe75f56c228b9827f8e5f2cdf96f15a37bebf97d4e16b27::wit {
    struct WIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIT>(arg0, 6, b"WIT", b"DogWitMoney", b"$WIT coin is not just a DogWitMoney. Its super cool meme vibes wit chads & frens on chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sqh_H_Xz0_L_400x400_6b84c9586b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

