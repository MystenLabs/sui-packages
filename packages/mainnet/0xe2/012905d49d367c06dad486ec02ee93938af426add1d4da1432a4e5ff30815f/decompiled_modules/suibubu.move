module 0xe2012905d49d367c06dad486ec02ee93938af426add1d4da1432a4e5ff30815f::suibubu {
    struct SUIBUBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBUBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBUBU>(arg0, 6, b"SUIBUBU", b"Sui BUBU", b"The cutest memecoin on Sui network. suibubu.meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DRCEFY_Mv_400x400_8bb525ac1f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBUBU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBUBU>>(v1);
    }

    // decompiled from Move bytecode v6
}

