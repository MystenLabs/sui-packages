module 0xe7e89343eb69ce210f6069bd8188daa42ea2a3692cc5e4fa27daf3eb191ba037::buynt {
    struct BUYNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUYNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUYNT>(arg0, 6, b"Buynt", b"Dont Buy This", b"Dont buy it or u will stink (even more)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicobih3xd7oadanorrki5e5csmzskjg573p7xaznqmopqesnt7hti")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUYNT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BUYNT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

