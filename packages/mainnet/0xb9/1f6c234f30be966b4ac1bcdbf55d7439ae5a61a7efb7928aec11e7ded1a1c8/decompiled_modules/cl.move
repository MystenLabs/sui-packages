module 0xb91f6c234f30be966b4ac1bcdbf55d7439ae5a61a7efb7928aec11e7ded1a1c8::cl {
    struct CL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<CL>(arg0, 9, b"CL", b"Crude Oil", b"represents 1 barrel of crude oil.", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRgIFAABXRUJQVlA4WAoAAAAQAAAAfwAAfwAAQUxQSBYAAAABDzD/EREahATEdNNFC5SI/k+Ald8DVlA4IMYEAABQGgCdASqAAIAAPmksj0WkIqEa+xyYQAaEtIBq/cNsg2z67E5TERDkKKyB5Xvxvp0GfvkffdMn3///0Rs/t5qplPDkVtTTQpdILJaGKWm2F4gsvYfOuFLe2tX0ZjTm47hQRWXgzFkAMXT2zQjONFuGwQ33/TAhtIZpPszvr9KN5EM8iR5bWBpI/pNevOrTVj/n9Hj3Qx8z/O+dkboPXWDuLWPNmE42M1cagV+UGxPFnDzKNbUiHxoKnWgPKr9IHv6OpZ/UUysOzKlcgvY1yZNsnnFmF///llwFJRAA/vqtz5LUA9iV6yANxQ2sX5yqu8x0e9yX+v/SulQ2/tbpL19JfwYoDyux6dp4J+9lhPyC3bnjp2DjaGzA00XRpuF9zp+NidmbnY9LLAb03Bp8AEmuibS+dS8qGNeHmDV31DR5gtTGGQDSBx2VtlNRukPujQSw44QAU7J62FK5vIZL1zDS3Ya4w4jZFi/sGVSw8339jdhQ+FagAaAzIY3vkf3JdpC60OHv09O8y4/g0bJnRUf6Inzvrj/ln8T40Iycn3XX8T8XOSfObv/iqkRF7k0Wsuf4Xjun1fc94Pu+HdhyvNCZZFOidHcR96lbJA6x4Gw1d7ljMxGDj3i2ZUcg/87s+VlZbckACLzwk3tjc9NgI1iA9/3SxG8rs/nKgj0NtsziE2kMOurrQmqK0cbuRkqn+R7UuHPB9YY2mtKY6rE1Ip1tlOGOfuXlG0MXQ6OXYTaIaZFWJ9yKm/dsHqVD/QjtH0iCxfQrDA1RA7Fr/1i0U+OEpntyi2ijrUEY6lRXkfjd1wqo4mZIMHDTjVxdv3qJ36AHE8jx/LpBH38QA5mzQ09IQimmLXdXZZuFV7f7wmEjyjn8zlmeEoN13yBuVUmr04X7gxXNhQwRIEivC0GTiuxxBADcNTTQdDySgkPqEoHFEeq36cXn4SQl23RyNE+SWJcCzQPUFnbWy3lN6P0plNmmQR9Fz3RjueAoTYQqYVCfdKjw+VpE4e3KkXroR8d8z42nopBlXRAsuG2ZNzpfRDhRLylj3Cv2vmKzC8qrika7XNs7Qerew//flx6LNWApz2lEeVxAqY83JCZepjv4ZkYlX+xuq0+6yhkqXvqx4UjU5Q+Cvz86d0PtwElXIR/H8G1shQQsXl+IbrreSh/9knJQDmrQyoj3u5vD+H3WN65l7i1t9QJgLJtvmZvo1WVDgBOIHxF0y/Ovu16ZNPpPAKRCQXkLFIc0R+LaCL9i+gDLxFyEPq4XkA3K54+S5g8XAZHPMMT49DbGLh3K71b3OU+2v1Q/jqKcWxutL1Z66Obg1hT4IcM14LqJ5WMQfABT5UyGHRN4bKphrvfzbizKeCvnsGxVtgSJrJZue0RmZA5enkshNrK2YP9a7oUvEWxSE/eXeUFbzvNPhX9lCBWMLhptG6d7qbRfkZ2gKz+7tAJuJRRaiSyDTPcWfBOOuYeaCTglljx/zL0suEmFYL+aqpy630hWdkh2GwjxxVD1cUsjd5ErE4dELlVULBa5cgj5EE2m2FWwa9kxcSOyvMC+PEnOrBC6pD7kMTiz4NSBXCqOpb98cp/6Blhg7QJ0HjK+4NR8fSTvFyHSWsV9pTmqmgEFYaGBChAA"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CL>>(v1);
    }

    // decompiled from Move bytecode v6
}

