module 0x786622cd7606eeaafd1e9587ef45836005f19a7e8b34230be33a7980be44ccbc::suizilla {
    struct SUIZILLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZILLA>(arg0, 9, b"SUIZILLA", b"Sui Zilla", b"Zilla Is Meme on Sui Chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1845502133724225536/oQpyWHzI.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIZILLA>(&mut v2, 443000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZILLA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIZILLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

