module 0x578fe2af71c69c8b11bc8b14be1b8e4aa5d0d8e9edc8fb7fad3a898e11f26d05::arv {
    struct ARV has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<ARV>(arg0, 6, b"ARV", b"Ariv", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRkgEAABXRUJQVlA4IDwEAACQGQCdASqAAIAAPm02l0gkIyIhJJcaCIANiWcAloNEJRBrB6pfUBnAP1J/WbsLf+jzQOAA8r72Rf2Z/YDMbPHfY9/h+ic8M+zO6e3+/4T8ruSeUxXVd8lqL4FP1040Xwr1IP5/6E+fL6lHJPNq83u6CZSSKkY3fMbJXXJqdNEnzyBH1YvPzkTxD0Jc5AMQNw3+jW9QotnycCUnEy+6bwwX6ttg8GuWSD9N6KJFljQ0QKeWC6lBVE8x2sSfeA5eUkVJuuxOvo/U0P/rncavN7vNp9qCIAAA/vxKABWq7uKKmZdDZggIRQfx4ZyJPVLAswO2rspxJ4XYvUOoCimaiboETZeKPtpsX2ltCWrRyk4ALM3ISAqiy+AfAn+iLp2RgTKO/+9h7xyS8eNweF+04gxeNf9JK96vJ+5oePZ+/27pQYajlUNYkzufbo/vfsb7bG7Cp25XWk+osLbgsN6a/LxcjQw0lf90XN1f/SUrJ/2iv4CtSSGPlnQU1ikAT1mHn3jkkXk2P5F/5TPbd8Qoe+2EE5kBTbn0pD+qWovgt2QQS477IytKL9f12nuDW8IHEBpvg+zcm5no6rwz4C043NThW3OcG8mJUCoYzixtBl+u7jL2DnrP8o0k/73SH0oqjzLu1PKXRvhX730Y/6Cs+X/1xrMY6qkH0caHBwBJj1nIF6O35FW7HLDx0ucMxPGqyLzNbRegHOQAeUcmq8brwskO76lOUqrYL3F4ecq6OZ6jqJBcPpv/OXwXqwmwxCCXOa4cKuoTpKDhbTbxsf995nmUHvnFDnrEErnvQ4B//nBvVy9PjwmvLs92Obf4FTrp7z8r/t+9ktu/0TXdwLtXKQ75pWVLJetHcoNbxSLzrqa+558NuxzurkqJPLIwnzWjtRoE/UQ/3IHFftbeH0zmqzMO/EBX2fS1j17HLaqp/GWSfyC5vK6CMxUQJVDaCKFU60/BV1+Ad23owSweoBH7yPMuo/CXL7qC3dZXsxgDqZUpM2Ta3HH8f776xemrxDr1q2RCvj9CbA+JJOQn/eqaB/U/kNM3/Xp8hbaWYI7NlHB/sq/mQp6MjurKyb/J2a2BRbiWyIv0jRMoiXO0CEWLXd5UrkRG4R9EOCkLhlvYhFUcYhB2zYYHZrY62v+89QgtCNMZqoNAkNqvF3dZo7PBs80+LHQSxL1G6yYtRvRDWaM+uvdj86zhn528flNabW78WfhMbQauYZZO+cTtl21UungTCZJXGtDt1DE1915p+3ze/qIEw9Mdpgs6riutVmV2K/v7m8KrQ7U3kmT2xAHgDB1Q3J7e2G4hlR9TB+fUsfzNwM7rOum9M8D3cSC33wHfqN0uJ7d/nxVl8s9hnbUZl5GMdw0dP+XND/Ew1Uc8VtHsm0bdqnS7Dk4baBmLwb3gLgzKwoyjNAKjhqNNBZtcnKSNn5QoWFBzkgAAAAAA"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARV>>(v1);
    }

    // decompiled from Move bytecode v6
}

