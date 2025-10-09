module 0x9d83ec6e1196ef78bf7ead92679a0c1a1ff2256dbf92608e75d2d202bf70543c::xmn {
    struct XMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: XMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<XMN>(arg0, 6, b"XMN", b"xMoney Token", b"<placeholder>", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRmIFAABXRUJQVlA4IFYFAACQHwCdASqAAIAAPmUqkEWkIqGb+9RAQAZEswBmKx3/iPxu8Jj1nX/x76F3nDt10tyH+vKeh5gH6d9O/zAfsV+wHYA/xvqAf0n+zdZT6AH8A/uHpr+yZ+5H7b+17qsvlLsa/uteD6GexHau3QjI3piTAlTsz3yN/Vu/uWBh1QSyXmv/7I3dZ34yo0Fz2v9Npn2vL5hVsyDZwp2eG4OBIJWjlMdHIl7wc9mMV5mP2VAbjCivCy+HpzB97UEICTNe79wN5hmbVqnaHXdjPEIAswOVCXKdoQNRrrqqXd2i5/R3WxIKEtWK88yf7Bl+jGhV1SCzAwvWeG5PIf9qbO0UdP+yILHNRYgA/v12eL3DLPsrYcIqHOspkfgueyi5y4kyzgHFnlMiBt5CgmJPPJvDNASMQieWbhU0/oQUfeqajJyxOdNxQ3BiX0V/2yym60NcAi2vyqFuERGYsgc5dtMoBORMKdPd48RlhFb+jopIS7RsKhXFXaDFNuIVFkubMIpl6RplpkRzPVH0B9/KHhhjHtxiGw2Y8Kve0quBpkzk9TWoGlpV7lHMcobb/mSwoSc/QeO4m6IUbisWqSwx2GkA4mREK6lzgau/1+FvK+KblKUVCzr1fKyZAlie7zSLg3r74BlkCUcIRNzvQWIda9oFgEJGCEkddnXyg+I+sYrqbmcUmsq2w6t7MhAAAJIpea0RSypx5jdMQi0CuMdo2Mjnm4pH5VYYJCsQgXAXKuqm9vEkFum229EfWkJ9CidOEfupUQh7OKAdoZhMr9f7Hxko+8DJkmZz+qEq43jDRPRdD/JpApFqZ7yBAUVeDf1g74n3Xg3nKt3Rjz/WRwAZhT1mx6CjDmfZceUx60mbasRiSGpORbcbnMvzfXKj7D6Q92CSbCrUDxsNBd7PJP7857rikycvvkNKr3dbgkD1/D+etI4Oln3nP917oMFgcX+Z2VG8cyf4+p3KaMhB0kjCa856sgJL0Q9UYicjg96v9pqyAatpI2iIqDCy4B4CQeibzPtlFp+zc/mfklqs9Ys3f22mz/C+rBs4pGn32u67tscbreaBtbk0bzlPNZWd7rXR3oU/+CXeIEyWLmF/Lc/xJ4wd0FP4L+v7hXUQHn0g+aVpi0HD/xH9Jcax0+3XZqJa+NIBikWixvlqUPqiSJYMNsD9rxOa7uAED9tS/UN1wlktnfpHOuvAAimkZXGMZxkecY/598VG0WY3g2zegh4aKaHF82j22ybl1p2LLfyAkLTXh4H94JobvsyGR1SAj0STCogApnZKut8ygJ/1iIhaf9XLnZsB8NnhT5f9OPfzz4BWVXzJgnIy5F8WLzjNNiKU/ejmxgklVpjDQUYgHSc69Csqftkl2qDkB8HQ6GVhdp4KRxr23wPDzRPQnuTB/HjJ+d4Z6UufiS8C/mK3He5lFyttw1EK40WevGuSX0w1Rupd9j9+EG6T/fB77toz6wlx11I84AgTA1IX+hnG4TE8Aism1j66wyf6EF3H6IjsyQWJhoeZ14iKwP/Y0R2kf6ovZHjm/+MRNVE6KSd1ScFcwW2A6VJElzMx7QNWVSbHerk9VUSU5pndruwgUuNL+v+v/GRCjGkS8dQ113ycfZbEeqFrKWnzUmamybd24rPa+ahCqwq6QUgspBY0/jMyrBHTQgP5uh3Lwuv1SePbN/3I8daU41gBrNFr3sMPGxZgHzpj4bDG6DBM4kSt436QJBMFZpekMJLJVgpDSLmfGOjhQYi+yIOhxFPMnf/mRIduhZjrX0xOaxhGVOPeeQ3DudI3UhVKrYydyA/ipY/F4ZlJNB28AbStYPPy4QAA"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XMN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XMN>>(v1);
    }

    // decompiled from Move bytecode v6
}

