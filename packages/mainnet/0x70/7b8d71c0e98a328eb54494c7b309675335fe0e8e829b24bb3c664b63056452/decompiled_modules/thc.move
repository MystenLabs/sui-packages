module 0x707b8d71c0e98a328eb54494c7b309675335fe0e8e829b24bb3c664b63056452::thc {
    struct THC has drop {
        dummy_field: bool,
    }

    fun init(arg0: THC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THC>(arg0, 6, b"THC", b"Crab WIF Tusk", b"A Rare TuskShell Hermit Crab appeared in Sui Ocean.Deep-sea animals like this one could only be collected using awkward trawls or dredges, and then sent to museums where they might sit for decades before being identified. Very Rare to get!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_18_07_06_04_d5065ff154.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THC>>(v1);
    }

    // decompiled from Move bytecode v6
}

