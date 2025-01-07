module 0x228cd95894db366b24c146c9e8bc8b8f1cba5c1a6dd8fc7862800ba458b883f0::wewe {
    struct WEWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEWE>(arg0, 9, b"WEWE", b"WEWE", b"WEWE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1841294923657789441/vVBj80li_400x400.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WEWE>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEWE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEWE>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

