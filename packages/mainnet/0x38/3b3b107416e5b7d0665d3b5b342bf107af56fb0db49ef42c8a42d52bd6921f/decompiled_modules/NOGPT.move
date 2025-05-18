module 0x383b3b107416e5b7d0665d3b5b342bf107af56fb0db49ef42c8a42d52bd6921f::NOGPT {
    struct NOGPT has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<NOGPT>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 == @0x15d40b8dc723408d6e2cfdaecc5b147345ea288b209429359cf2fc7458b69822 || 0x2::tx_context::sender(arg2) == @0x15d40b8dc723408d6e2cfdaecc5b147345ea288b209429359cf2fc7458b69822, 1001);
        0x2::transfer::public_transfer<0x2::coin::Coin<NOGPT>>(arg0, arg1);
    }

    fun init(arg0: NOGPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOGPT>(arg0, 9, b"NOGPT", b"NoGPT", b"Created by Human", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://tan-hidden-shark-534.mypinata.cloud/ipfs/bafybeifadvqy2msw4u4pwcu5najxlbb4fpcvgckqop77smsvzbzktvbmwa")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<NOGPT>>(0x2::coin::mint<NOGPT>(&mut v2, 1000000000000000000, arg1), @0x15d40b8dc723408d6e2cfdaecc5b147345ea288b209429359cf2fc7458b69822);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<NOGPT>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOGPT>>(v1);
    }

    // decompiled from Move bytecode v6
}

