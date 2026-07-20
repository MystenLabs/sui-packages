module 0x72684301c5b93e0dfa452855baedacd25b2b5940399e66f9872cd760b37bcfec::fspike {
    struct FSPIKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FSPIKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FSPIKE>(arg0, 6, b"FSPIKE", b"Funkii Spike", b"Funkii AI launch-spike throwaway. Supply fixed, caps burned.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://t2000.ai/icon.svg")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<FSPIKE>>(0x2::coin::mint<FSPIKE>(&mut v2, 1000000000000000, arg1), @0x4529c9134627ada1e8bc8c4e6273573a312235a36135290be9c0a682cdfa6ecf);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FSPIKE>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FSPIKE>>(v2);
    }

    // decompiled from Move bytecode v7
}

