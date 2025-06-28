module 0xf3985ffdab157b43fd42de625f82fd1f3ad8b80e62287a936231709dd350410e::bos {
    struct BOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<BOS>(arg0, 6, b"BOS", b"BasedOnSui", b"Decentralization, accessibility, transparency.", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRoIEAABXRUJQVlA4IHYEAABQHwCdASqAAIAAPm02lkekIyIhJRzKOIANiWQA11lBfs34AarFwn8d/ZZor9N/lf57/nPqAadb4V+Ff0H+N/w/eAP4B/AP7B/AP5FvgP+p6eHoA/9vqAf6LqAPQA8o/2D/tG+AD/Hfwj////jsAOKq7vusYPRd1zsBxf7z3+vgV/nawKeV7kz5wkH0Qh4lyuXCjm1JWkS5XLX2SngBlo+JtqTEk1LwuYMOJMa5XLX2ckOhi0AbGqESiSU73m8oElwEWc6b+PifNQvbyv6oX7lEIZlssQ09Ol7V7xscAIU64+baIlpkn0LJx2WyQHtTV6h6Tm6/1QKCpf+HBqVzTiSv0RTAAP78rRAA9/0273Z1Eq1271GLF3ycTGclYXCtUWHl7646DcFZQjxMJVi7FsWyba10JX+T7XaYYp6mLTuYgpU//5QdLPaosPM7YJTo2v0zqN61bnmUju/tTJc7xRL2/vPPH6hjQl0C14MAxDVdYKxAprBynPfCnpO8eGgFilvGsb51rmfVmtJk4AwOX3EYUEBcDyRQS4HdnfyDKNi/1gNa0cmcSeIdgM1cI1AHze8vXvQMrKERETIjh1UBLcbA+Jx7/pt3uzTO35l1UIDqGAq+UHSz2qLDzSmDHcVvusGLbk3m0dhz7W1DvBJxOYekRu8XWH7fy1Ll5OgUPMobcJ7voRwNVA0RfmPyD5d1CgC2voLx7DkRHq1meoF6xWKYhQaXVFW8QkPPw+zeK2LjNlO1HSk86hqZfqVQlWnsFUxofwxPTBdAOzx22D+e3BAW6EGVoww9GcxcuT0rNJeAp7RzX1939bqylxHOjcwgX6+eBYVrikFA126hr/V6/tdsdN68WtQaDnmbTtApfOrvs8Kud5VnNLcbBjblXpdaeGDsw52lHGbxQcXIQqSyeeGMLPEDiYxYdMhDmIxzNtb7etcOdmNrQpm6ecKqd+PJgYQ6pAhE5ax47leuL9ect8I3ZheKrfr1t9JdqVIcTNzBrPAjOqN69fgG5ACgIN8KnI7kk7rLODkAr9Zo3N3ed0KFbA2lcrl2dicK2xfYb+QiILLHpvNkTUkSvr8X4StZeh3+AdBv4P+x84AZDBwUcK8IRvSheD/fXlE81Jaz4pPBVNmXY8bbL/OtVuQ2w0/WiftdbRoW9ivd4fg6Wh1BGE//8oOcp2a3v9HyzTohTKjdWcG9wtIX6HZ1ojiarDiwoTiUiZvQsJKttf/sq3xtb6NyUUuMu83rgsjkjuLW53pKPKCJjTNhtKvIFae4hvluehGl1RSKuORJUBvwNDchxMefvQJ+H6LNhpiMa/p/gCjqmoM0bHxXJeUTZQOlwcYe6DAGCx85Vn7ZL3A2ejjrTA7k+8vFd64kpF37fx5tF6hPdnNGbJ0tHqH55ghEv4dqqSnfKmG6s5QHbz/pjztfprmF2EDcckkTI9tSDHE/WskzyCPNzw67wAAvw8iGtxtQcxdOLaGUmAOOG12s92Alq57FCjJ7PE1v6LpQR2lsKboVAAAAAAAAAA=="), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

