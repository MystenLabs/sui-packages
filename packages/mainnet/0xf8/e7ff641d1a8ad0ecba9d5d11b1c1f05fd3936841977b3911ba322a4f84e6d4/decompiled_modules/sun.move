module 0xf8e7ff641d1a8ad0ecba9d5d11b1c1f05fd3936841977b3911ba322a4f84e6d4::sun {
    struct SUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUN>(arg0, 6, b"SUN", b"JUISTIN SUIN", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBgkIBwgKCgkLDRYPDQwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Ojo6Iys/RD84QzQ5OjcBCgoKDQwNGg8PGjclHyU3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3N//AABEIADgANAMBIgACEQEDEQH/xAAbAAACAwEBAQAAAAAAAAAAAAAABgQFBwMIAv/EADMQAAIBAwIDBgQEBwAAAAAAAAECAwAEEQUSITFBBgcTIlFhcYGRoRQyscEVM0JSYoLR/8QAGQEAAwEBAQAAAAAAAAAAAAAAAgMEAAEF/8QAIBEAAgMAAQQDAAAAAAAAAAAAAAECAxEhBBIxYRMUMv/aAAwDAQACEQMRAD8Ag99fbma/1eXs1p0q/gbVwLkxnPjSdVb2U9PXnyrPrbTL7UQZIrdvDJHnZf35VofanRdO07vP1MvCrC42XCKwGFL/AJjj3YNT/pdvahI0lgTHTK4FKlZjxD669WsR+7STVOz+u2L3Mkn8MvMxynJ2NuyEfHLAYKM+h+NbtSJ2hjttQ0ucWzxv4KN/LIPDHLhTbpF211ZRGUHxlRRJywWwMke2c/SuwlvDBshnKJ1FFFMFBRRRWMZR3yaLNca1ol7YLm4mWS3kCttZwvnXj7ef61F0Wwv71m0rU7liTbGWHcdxQggYPAZHHrTn3jaVLe2FlqFufPpkzTsOpQoyt9Mg/AGsvhvtStNW0q6W5bc1jEkm3zMcr1GCePrSLPJXRzEftAiht7ae3e7ae4jbY6u5JX229PpV5oOuaaJJbGWdILuMjckhChuAIIPI8PnS40BCpq7s6zeHs27cZHp6k/Emkq7vFuNc1LBDBXVc9Dhdp+6mj6aCnPGB1Mu2Go3cXEB5TRn/AHFdFYMMqQR7V5seYQTcgY2JK/4+1WVjeOh3QO0bbTgq209Ku+t7Ivk9HoKikvs524sW0qJdZufCvI/Ix2E+IBybgOv6g0Uh1zTzA1JEzvO1aTRewmsXsHCUQ+GhxnBchM/Ldmkm67PPq9po+qWFz+GljtViZwMjaOI/U/WmDvrulj7FtZMwX8fcxw5I6DMh+yfekDWdbNn2RgstLvlke4ULmJw3hrjzcRyPT50mcXJpIfVLt1lXqXau6h1a6sfFluVtiUjuGbhkcGIA4c/0qt024InKyjEjoSeOQ2Dzz86T7zxbS5nhR2EasQBnkKn6Pd7HgUsd0bYO4/0t6fMim1JQmLsm5xGiVVLNw+YOc12gfwWiYsACSv2z+1RyQ8bsuA4OPvUfUZWTT98f5o2D49uR+xr0NJc0ZlkUjO7HtRVLZzySwK+cZoo+4HCV3q9rrntD2m8GxZjpmnuVtyqnEj4wzn16ge3xqgtolRAChVm6YJziiioq8RRLkpNfglGpyFUcq6qwwp/tH/KiNHJsikSKQSLgHynmKKKVP9MJeBohkaS0MqK4JUAjHXhXxIztp86zo5YIeISiiqoybQrDtNaz6XM9jeQ3AnhO1toLKeoKnHFSMEfGiiitFvEdcUf/2Q==")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUN>(&mut v2, 888888888000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

