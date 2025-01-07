module 0x7bf94ef181fd54d09a67be959ad9fdcc64c503baa95ddfbbd84004f75a9934c2::seal {
    struct SEAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEAL>(arg0, 9, b"SEAL", b"Neil the Seal", b"neuahnethunoathe neuahnethunoathe neuahnethunoathe neuahnethunoathe neuahnethunoathe neuahnethunoathe neuahnethunoathe neuahnethunoathe neuahnethunoathe neuahnethunoathe neuahnethunoathe neuahnethunoathe neuahnethunoathe ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-fun-7k-dev.nysm.work/api/file-upload/5296607db747ceb4522f3a7e57aa5881blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

