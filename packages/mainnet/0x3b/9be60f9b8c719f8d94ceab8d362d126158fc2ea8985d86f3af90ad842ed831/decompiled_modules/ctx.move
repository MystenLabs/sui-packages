module 0x3b9be60f9b8c719f8d94ceab8d362d126158fc2ea8985d86f3af90ad842ed831::ctx {
    struct CTX has drop {
        dummy_field: bool,
    }

    struct MinterCap has key {
        id: 0x2::object::UID,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CTX>, arg1: 0x2::coin::Coin<CTX>) {
        0x2::coin::burn<CTX>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CTX>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CTX>>(0x2::coin::mint<CTX>(arg0, arg1, arg3), arg2);
    }

    public fun balance(arg0: &0x2::coin::Coin<CTX>) : u64 {
        0x2::coin::value<CTX>(arg0)
    }

    fun init(arg0: CTX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTX>(arg0, 9, b"KDX", b"KDX", b"Kriya ecosystem's native token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"data:image/webp;base64,UklGRjYNAABXRUJQVlA4WAoAAAAQAAAAXwAAXgAAQUxQSK4IAAABwHTbtmltk9e07z2hkm2VbLuUthVoLb4W9XQtzK+cdtZs2wpHMpC2zfeeM3phn/vc532+iJiAcZsPh+U4xhj3feHr3v7tP/pL7/6dD3/4Q+/++R/5zne86kX3GWOMZTkcxl15OY7DeNCn3Plr/7a5ePuXX7jzMx8xxjgud53lMMaD7/iJPwu29bSu27yu661T5r/9sVc96DAOy+GucFiO4/jir/sb2U5bsyLRvJ02+ftve/EYh+Vw447HcbdP+IW0rZvshkwIbevG///aF91jHJebdTyO5eN+/qRT9kuR2kOkU3r/Zx3H8XCDjsfx9J/VttZUqGRupqC0rrYff/44Hm/MMu7/rv+yrWVOKWfLnDkq6+Z/33TvsdyMw93Gc3/HtorInKkkVEKVuXXznueP5XADjofDl/63U6TKXhJEhYqdoNX/fOnhcLxty7j399q2zFdBkSoiEyHRtvmu+4/lNi3jEb/ptCERmirKHER2K6G65VcePpbbsoxn/7k1qURTEZmSVChKJdHJnz9/LLdhGS/6e6fK3JQ51U6V/UqZVMjqn140lmtbxov/zmqKpFJSoVIlqmh/mtn83YvHck3H8ZS/tTalKSnaddWSUiZEs9VfPnEs13IcD3i/VRLUnhSaFQkTSmVOsvrgQ8bxGg7jbr9oFTqviqSJHVJTUkmKilt+9u7jcNky3mmFihQp8w6Us1UQ2nF+dedYLlrGF9hcmqtGMtd0fjrfns3njeWCw3j0P0whCe2eS6k0a1baFUJo87dPGIdLvssJQiRcaT9VmsluhCCJkx8dV1/Gq2xQmkS4Fsi8k2oiCrJ55ViucBgP+LC1Ep2XLtI+pVISqkQRmz952DieW8Y7rZmbCalcGElCFBWFnC0nbx7LmeN44n/ZIiUUkUujFIqyX0nQhM0/PGIc9pbxNU6pUtpFqatRks6KZJqVqFq9eSw7x/G4/1KU/XL+IhVBdpNQ5h2Uv3n4OEzLeL1ViUg5Wy7P+YiCSJmbtHrLWMYYh3G/j9qCzivtXhIVzUS7SplLlM3v3Gscxrjb+GyrmlAShUuKEspu0UzmgsTqM8fdxjiM77ZSKqIKoa6kq6rSLqSEIqXVD4zDOIxH/Kc0046kug6Iwo52z7Rnkn9/xDgs49UyMQllrlzanhQiTCUJ2c+rx7KM73RqryhNQXVBlUQVym67NJOqk+8Yy3jAR20iFJEi5OIdFXuzMiekvc0f3G+Mp0kkaFLm1AU5X0QUqbKbOSnPGeMO2540U0XqIkWZSyVSplCJUpvXjvFNNrtRVERJLqySKJF2JEpTCG2+YYxftYp2NDufLji7t1tNuztno1bvHvf+Ixsi4Wq5pEJqKpqQZiVSqc2f3O9J/2wLBSWqdsoFFMmF7YsqpKZ/fuIrNqFoh6AkXQ1RrjcTCYVsr/g0WwrVTmnavyCSayyqlAhSm898pZOoqR1zIZeQ6y9lP5JOXnmHWymqaBYiF+e6k8p+FVW33PFVTqQKhVCFulKuf0+VZlU6+aqvnhSaKopMbvYOIkxf/VVOiurcLkQ3pNJst1Tq5KvucItEZc6c1E2aFSkSbrnjlU5QRDIXphudEnGmk1d+pm1H5lQkQjeknYIklDaf9vJN5j1yxXIDm2Su7NeO7RVP+mdJs5I5gm5Hlah2UlIUqs0/P+l+f2JDZC5iym2toHIm9ppKmz+693i3Va6cgnRb2LliUTsItfrVMb7BCukKSKjrKoKugEr2mzffNMZrbVRUEUTK9XYmc0TnkVLY3DHGcwRB9qLQ9dCOORJlTgRJnjbG/f7Auhc0myvXG0klmkVUuermow8Yy/gOp3QVZ0PXIiXFjkj7opROvnMsy3iN7Kcg2rveEEnInDmZC/LqsRzGI/5dyG4VmdI1lSJzKiVF0VT+8xHjMA7jB6zmVKYqJV3UjqRSyH7alWL13eMwxt3GZ1qbCEmEdEmEiJD9hCrsZPXZ425jHMa9fscmUqmgqEsSQpAiQkEllM1H7zcOY4xlvMVqvwoy5/IJVfYjc5mLktXrxzLGGIfx8L/RGVdMrj8oMpfdKmfzX48bx2ks481Oaac0tdfVSkkKaV+SSkly8jVjGbuH8Yh/kJK9mpDLEAoimTMnu/mvJ47j3ljGm53IbiHJjQyJVEpo9c6xjLPH8bA/sSUVUarU1UoRQueUSvvYfPgB43BuLOOVNhE1waQplEgoNSWhFEVo8+qxjKv/qJPs1p6dNKskyNlEiSn2Tr57HMaVD+MJf2tTUSGqzKVIJaqkTKpIU2nzD4+5ZCzj82z2s5PsT+SKmUt2p/Ox+YKxjEuXcad1isy5ajnbTkX2IyKU1bvGMi4+jLv/rJOklFKliab2Okulyo7EyS/ebRwuG8fxkA9aZUdMiMxJdiMJslsqVu9/wDiO61zGk/7KqooIKrSr1BRFpIpEsvq7p4zjuN5lvOTvbQiKpCAkiEpBURLJ5u9fMpZx3ct48T85IcmkKKWSIJhyjsrq7188lnH9y3jBnzt1rlnaF52pKSpVpNWfP3ss43Yu4+G/4lZSODPHRElkSubQyW8+Yizj9i7j/t9l24KS/dppEmpCe7RtvvfeYxm3+3g4fNl/W9tFU0KSqKSIVHTy3192OBzH7T8s4/nvsa0hikQpMtmvIqyb33nuuNth3Mhl3PtN/2tb0Q7KlPMpkrRu/utd9x/LuKnH43jeT2zWNUIIpSi1p2rd8rNPH8fjuLmH4zh+9vvTKYlSOWMO0Smnn//4ZRyP40Yvx3HPL/61/2dbt4TsVuZgW7f0C59wt3E8jpt+WA5jvPjb/16201ZKKWfaTpv8zde9+DiOy2HcBQ/LYRwe9Kof+1tzp1vrum7zup7WDfqzn7jjwWMclnGXXY5jjEd+1p2/+C+bi7d/+7U7P/XB4zCOy7grHw7LMsYY93nRq97xnT/y8+/+0Ic//Dvv/qUf/fa3v+6F9x1jjONyOIzbDFZQOCBiBAAAEBgAnQEqYABfAD6RPJpHpaOioSuU7TCwEglAGiAWCkkWV8Xbbc+j53O+Abydfqv4QdxCRcbHY1BWj3Magvkwewj9u/ZG/YBFSDf+S5tWCW7NCRu8fQMW3Emh6WL1s+Vq8qRO6Td/YxLE+HqaepfVlvHoR11OW4CjIA6sGgVLld2oi9TlkCH6L9HvP7okEkMZEFcOUmTJn/akSEwsjHBOJcepqyiB6jnAbnHuD0iiBi86uBm8LEhZcqRxclJasN8DfUky6zD3bFAAAP68DDZ2vo6nGHHdx9w1CzYKvbqnBShP/VugJ+fti5GF0ZrHUTCgIRZDkckqkk6OMlFVjAJR4+Tf6XGXZAt3AtCk3DwjJ/KBubxIqJVpN/pemlh9tLjTH9nlXMUXOD/v1WJiStQGaLMezDqrBVlT1t5wD6dxwkNyPnEFU3MKgw9gw4W8dczfCnQJbSkiLxAEpZzrvbE5Px4M6zkYCkOM5+4sBjLreyX6hUgjD/8f7a/xnLdNhLNLbml/gMh4f79NV1BWTZMbo5xKIaEwMwINCQaEfq2dFhdgRDizzyhV2FgfDYsSF6nXFZdvH85PUckIqP7yr+90OO37knIjkxTEJFrVGovzs1u48Al/hiitF6jUWQjDmy2adhRR57aLkeM0VtuY/7U/yte/5+8+Pp036ez9a9ax/3kumpW+7mJcPM6MeptIIf9+A6ycILqrdBcxTrdDtb8PvnI+c8v1Lsfx7p4JpFU14PzdzsSBJ65oAwC2IBOhPLy17eOSZKrSN5XzTeQ2ueSPUcY1Y2Yx+Q67kq6LX7fi5odoAHB0hnlhC/KBRzFMvYCtxbGp26SvVUFA+CbkcPe13NeOPDMom2O4GFwGgB3HIpde1qhI1toht6jKhD7emjU569079L7jqnird11pqjEStM3NQBYfBDglP2zX2AXhnC5ODSF34Bzt3F0WhMevBpD0nMAyrIeE32IwybxdGaJ9NXTyThTsm91sypY3QcawEYpgIktjsbR/gGAxI2M4yN/zDJ9dHtlU/jXFv4wOopl42d6m9MRy/t5GxeM2Hu7Fnlpa8c4qPUTgoYV2zLhrhecddPCATlQoAH7empe0Fr07Jfu9sycYdNgdPD9UUuj6y0EIqCaH8ZWyp3J/rqMGri3HkDSjtEAkIrKT8mK5ZhkkIfMysUiiwy8KeVrFtQuXG+wNOXJ6Nx2v6VUxDbZwd2FmAjXQdSPcccI9C1W8wwXOD7qQThDEf+yFipMKzDa3NP2K2L1jIEoCK+M9ZoNnXPJx6wdBuQ3Ivsz3mpPbGuLFPtCAgtt4h8PVLzcbmRRXXn81AFOwfjX9oh8HQtBM0E3Kz7PC8IlWg+h4TEkQLsZ/VMLGkndHpwK2WwuTTOnx/E1Awh+/ffUJ7phc8NwRfqr0X9e5WCQYXzYso5D7ByDubZZ/dMOp4fVDJXhkE8B6iPFgWJ2qfTvf9ejEyPwN1Ni1AAHYOhD3olweNuccK+AMYAAA"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CTX>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<CTX>>(v0);
    }

    // decompiled from Move bytecode v6
}

