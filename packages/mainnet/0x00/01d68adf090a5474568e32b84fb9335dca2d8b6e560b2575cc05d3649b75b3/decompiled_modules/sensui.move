module 0x1d68adf090a5474568e32b84fb9335dca2d8b6e560b2575cc05d3649b75b3::sensui {
    struct SENSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SENSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SENSUI>(arg0, 6, b"Sensui", b"Sensui Bean", b"Tired of the damage from all those rug pulls? Sensuibean is here to restore your health! Inspired by the legendary senzu beans, this memecoin on the Sui blockchain is designed to heal the wounds of past losses and satisfy your appetite for memecoins.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_9601a21c56.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SENSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SENSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

