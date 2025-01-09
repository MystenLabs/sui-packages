module 0x3c2e6cdfef947a08d2bdceb7d76bd560bc5e23ff0d7a146e03eb181ff23bcdeb::usdp {
    struct USDP has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDP>(arg0, 9, b"USDP", b"USDP", b"USDPjdinjxjdjekdkeoeodjjdixiejxoodoejcjcdkcndkkec", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/_uhVsTpyALZdZz-_Jq1a6GuyEoLfcqCzMo6x796ZpDQ")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<USDP>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDP>>(v2, @0xfe9f4887e672499bd05e5ef39cad1c428d171baebeb7bd04da87513b64ccdf4d);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDP>>(v1);
    }

    // decompiled from Move bytecode v6
}

