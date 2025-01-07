module 0x1709fb8eeb4c062a972ec0c897297de3d4632056f506f76fa1aa7fbe031a511b::suitzerland {
    struct SUITZERLAND has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITZERLAND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITZERLAND>(arg0, 9, b"SUITZERLAND", b"Suitzerland", b"so bulish", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAAAFVBMVEX/AAD/////u7v/6Oj/qqr/7Oz/t7cwWu98AAABEUlEQVR4nO3dMQ7DIBBEUccY3//IKdKmAEtkJ+i9A1j7RTuSjwMAAAAAAAAAAIARV29j+lV96kPna9RZfepDChXmU6gwn0KF+RQqzKdQYT6FCvMpVJhPocJ8ChXmU6gwn0KF+RQqzKdQYT6FCvMpVJhv/8J7uPCuPvXjOufcbbiw3ZPfXjO57cMHr9eXFI4/yXpNoUKF5RQqVFhPoUKF9RQqVFhPoUKF9RQqVFhPoUKF9RQqVFhPoUKF9RQq/G7/Pc3+m6hpf7drm7b/NlGhwnwKFeZTqDCfQoX5FCrMp1BhPoUK8ylUmE+hwnwKFeZTqDCfQoX5FCrMp1BhPoUK8+1fuP9/uQEAAAAAAAAAAH7tDQenKz4/O5daAAAAAElFTkSuQmCC")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUITZERLAND>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITZERLAND>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITZERLAND>>(v1);
    }

    // decompiled from Move bytecode v6
}

