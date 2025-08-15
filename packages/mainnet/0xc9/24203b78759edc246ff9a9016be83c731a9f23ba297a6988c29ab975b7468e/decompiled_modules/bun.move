module 0xc924203b78759edc246ff9a9016be83c731a9f23ba297a6988c29ab975b7468e::bun {
    struct BUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUN>(arg0, 6, b"BUN", b"ManBun", b"Inspired by Sam Blackshear, the visionary behind Sui's Move language, our adorable corgi sports the most stylish man bun in the crypto space. $BUN is also a swap! All trading fees are going to be used to buy $BUN. LFG!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1755216683128.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

