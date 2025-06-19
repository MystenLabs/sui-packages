module 0x885201af0dae31b59ef9653771c08dda7dde6a4b8592351125bb89ceab9ed313::vm {
    struct VM has drop {
        dummy_field: bool,
    }

    fun init(arg0: VM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VM>(arg0, 1, b"VM", b"VENOM", b"Venom token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/0dd08802-d519-4fbc-a457-85e543057413.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<VM>(&mut v2, 10000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VM>>(v1);
    }

    // decompiled from Move bytecode v6
}

