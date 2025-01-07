module 0x26ce749982aa186474bd371f489254bfaab3f0d623ffdf73dbfe3671e313a944::payne {
    struct PAYNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAYNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAYNE>(arg0, 6, b"Payne", b"MaxPayne", b"I don't know about angels, but it's fear that gives men wings, the past is like pieces of a broken mirror, you try to pick them up, but you only end up cutting yourself. Put Out My Flames With Gasoline", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732062566314.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAYNE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAYNE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

