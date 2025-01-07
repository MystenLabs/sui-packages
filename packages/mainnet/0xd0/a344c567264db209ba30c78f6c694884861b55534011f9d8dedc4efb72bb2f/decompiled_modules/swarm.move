module 0xd0a344c567264db209ba30c78f6c694884861b55534011f9d8dedc4efb72bb2f::swarm {
    struct SWARM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWARM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWARM>(arg0, 9, b"SWARM", b"Sui Swarm", b"Sui Swarm: A buzzing hub for Sui memes and humor, where the community gathers to share, laugh, and enjoy fresh, clever content. Join the swarm and ride the wave of Sui laughs!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/855103474211594240/r3SACy4j.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SWARM>(&mut v2, 130000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWARM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWARM>>(v1);
    }

    // decompiled from Move bytecode v6
}

