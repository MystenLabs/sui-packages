module 0x5f606cf096853842871a842112d34a0982c18a975e733270737ed230798cf3b4::gor {
    struct GOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOR>(arg0, 8, b"GOR", b"Gor Wif Mask", b"gorbagana MASK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/c6ce6d69-8b76-416f-b139-1d245f9b5112.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GOR>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

