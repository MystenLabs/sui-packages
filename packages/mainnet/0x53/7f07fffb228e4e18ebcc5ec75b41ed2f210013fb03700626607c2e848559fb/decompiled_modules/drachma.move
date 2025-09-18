module 0x537f07fffb228e4e18ebcc5ec75b41ed2f210013fb03700626607c2e848559fb::drachma {
    struct DRACHMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRACHMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRACHMA>(arg0, 6, b"drx", b"Drachma", b"Drachma, the ancient greek currency", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aggregator.walrus-mainnet.h2o-nodes.com/v1/blobs/DYlIcfM32ICsXfTJR69kQ6Vv4roYnQbOvoUbRiwsg6g")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRACHMA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRACHMA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

