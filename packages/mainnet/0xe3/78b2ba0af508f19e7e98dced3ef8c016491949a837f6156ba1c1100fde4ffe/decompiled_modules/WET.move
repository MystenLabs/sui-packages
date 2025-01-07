module 0xe378b2ba0af508f19e7e98dced3ef8c016491949a837f6156ba1c1100fde4ffe::WET {
    struct WET has drop {
        dummy_field: bool,
    }

    fun init(arg0: WET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WET>(arg0, 2, b"WET", b"WET", b"Please make me WET, https://makemewet.framer.website/, https://t.me/wetonsui, https://x.com/wetonsuii", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/SNzW8gcz/WETsui-Asset-1-300x.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WET>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WET>(&mut v2, 100000000000, @0x1b0ee8c2e4c327eb4aa254d4ea6cb6acbf16bea35667701a0862fcb2965b6ba7, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WET>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

