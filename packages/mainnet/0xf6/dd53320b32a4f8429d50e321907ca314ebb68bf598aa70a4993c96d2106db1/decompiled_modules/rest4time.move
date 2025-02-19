module 0xf6dd53320b32a4f8429d50e321907ca314ebb68bf598aa70a4993c96d2106db1::rest4time {
    struct REST4TIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: REST4TIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REST4TIME>(arg0, 6, b"Rest4time", b"time4rest", x"69742773206f6666696369616c6c792062656474696d652069662049276d206f75747461206d6f6e737465720a6a75737420676f74746120636c65616e20746869732073686974207570206669727374", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2025_02_19_at_11_00_35_22bc42eb4b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REST4TIME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REST4TIME>>(v1);
    }

    // decompiled from Move bytecode v6
}

