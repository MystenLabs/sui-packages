module 0x57e456240aee986b6f184808a3b47998de0cf5fea391aee5ecdfd049b3302a3d::IKA {
    struct IKA has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<IKA>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 == @0x8c42e3714cc10f6c39f338fa5a976908042357b371075ded69f19bb845c1f460 || 0x2::tx_context::sender(arg2) == @0x8c42e3714cc10f6c39f338fa5a976908042357b371075ded69f19bb845c1f460, 1001);
        0x2::transfer::public_transfer<0x2::coin::Coin<IKA>>(arg0, arg1);
    }

    fun init(arg0: IKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IKA>(arg0, 9, b"IKA", b"Ika", b"Ika is the first sub-second Multi-Party Computation (MPC) network, delivering unmatched scalability with the ability to scale to 10,000 signatures per second (tps) and hundreds of signer nodes. Built with zero-trust, non-collusive architecture, Ika sets a new benchmark for speed and security in an interconnected Web3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://tan-hidden-shark-534.mypinata.cloud/ipfs/bafkreidtccgiv3eufr2mie7rba5hdkeeet5wzb7py34cg3m73wnwpzb55y")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<IKA>>(0x2::coin::mint<IKA>(&mut v2, 1000000000000000000, arg1), @0x8c42e3714cc10f6c39f338fa5a976908042357b371075ded69f19bb845c1f460);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<IKA>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

