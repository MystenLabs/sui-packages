module 0x9c4aca20e1ae9804810823da43cea20a9c94a261f5024de2a1e02124cac7685e::fish {
    struct FISH has drop {
        dummy_field: bool,
    }

    struct TransferFishEvent has copy, drop {
        amount: u64,
        sender: address,
        recipient: address,
    }

    public fun split(arg0: &mut 0x2::coin::Coin<FISH>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<FISH> {
        0x2::coin::split<FISH>(arg0, arg1, arg2)
    }

    public entry fun transfer(arg0: &mut 0x2::coin::Coin<FISH>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = split(arg0, arg1, arg3);
        let v1 = TransferFishEvent{
            amount    : arg1,
            sender    : 0x2::tx_context::sender(arg3),
            recipient : arg2,
        };
        0x2::event::emit<TransferFishEvent>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<FISH>>(v0, arg2);
    }

    fun init(arg0: FISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISH>(arg0, 0, b"FISH", b"FISH Token", b"FISH Token description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fishui.xyz/wp-content/uploads/2023/05/11-1-1011x1024.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<FISH>>(0x2::coin::mint<FISH>(&mut v2, 10000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FISH>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

