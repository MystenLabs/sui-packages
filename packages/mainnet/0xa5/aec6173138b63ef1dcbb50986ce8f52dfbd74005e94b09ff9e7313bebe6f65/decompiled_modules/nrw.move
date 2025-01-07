module 0xa5aec6173138b63ef1dcbb50986ce8f52dfbd74005e94b09ff9e7313bebe6f65::nrw {
    struct NRW has drop {
        dummy_field: bool,
    }

    fun init(arg0: NRW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NRW>(arg0, 6, b"NRW", b"Narwhal", b"The narwhal is a really interesting creature. And no, they're not swimming unicorns, but they certainly look like they could be! Those long, nerve-filled tusks help the narwhal better sense its environment.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732258106074.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NRW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NRW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

