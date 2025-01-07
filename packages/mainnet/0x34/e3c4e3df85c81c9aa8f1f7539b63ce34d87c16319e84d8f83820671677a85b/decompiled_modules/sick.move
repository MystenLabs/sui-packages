module 0x34e3c4e3df85c81c9aa8f1f7539b63ce34d87c16319e84d8f83820671677a85b::sick {
    struct SICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SICK>(arg0, 6, b"SICK", b"suckaniggadick", x"5375636b2061204e69676761206469636b0a5375636b2061204e696767612064692d6969636b0a5375636b2061204e69676761206469636b20287832290a5375636b2061204e696767612064692d6969636b0a5375636b2061204e69676761206469636b0a5355434b2041204e49474741204449434b0a574f4f4f4f4f4f4848484f4f5555555555555555550a4f4f4f4f55555555484848480a4f4f555548480a4f4f4f4f4f4f4f55555548480a5375636b2061204e696767612064692d6969692d6969696969636b0a5375636b2061204e69676761206469636b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i1.sndcdn.com/artworks-DwHaC7CkaFpm6WMT-os9CCQ-t500x500.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SICK>(&mut v2, 10000000000000000, @0x7620813509b036484552d6b905d0d2b9d29a0d55ffbfb8a9074af7393a7c5e08, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SICK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

